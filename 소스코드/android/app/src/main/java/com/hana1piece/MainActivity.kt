package com.hana1piece

import android.annotation.SuppressLint
import android.content.ContentValues.TAG
import android.content.Intent
import android.net.Uri
import android.net.http.SslError
import android.os.Build
import android.os.Bundle
import android.os.Environment
import android.provider.MediaStore
import android.util.Log
import android.webkit.SslErrorHandler
import android.webkit.ValueCallback
import android.webkit.WebChromeClient
import android.webkit.WebResourceRequest
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.Toast
import androidx.activity.result.contract.ActivityResultContracts
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import com.google.firebase.messaging.FirebaseMessaging
import java.io.File
import java.net.URISyntaxException
import java.text.SimpleDateFormat
import java.util.Date

class MainActivity : AppCompatActivity() {

    // 백 버튼을 눌렀을 때의 시간을 추적하기 위한 변수
    private var backKeyPressedTime = 0L

    // 카메라로 찍은 사진의 경로를 저장하기 위한 변수
    var cameraPath = ""

    // 웹뷰에서 이미지 업로드를 위한 콜백 변수
    var mWebViewImageUpload: ValueCallback<Array<Uri>>? = null

    // 요청 코드 정의
    private val PERMISSIONS_REQUEST_CODE = 2
    private val FILECHOOSER_RESULTCODE = 1
    private lateinit var myWebView: WebView

    @RequiresApi(Build.VERSION_CODES.R)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // 웹뷰 초기 설정 및 로드
        myWebView = findViewById(R.id.webView)
        configureWebView()
        myWebView.loadUrl("http://52.231.109.57:8080/")

        // Firebase 초기화
        FirebaseMessaging.getInstance().isAutoInitEnabled = true

        // 토픽 구독 설정 (예: "/topics/all" 토픽 구독)
        subscribeToTopic("all")
    }

    private fun subscribeToTopic(topic: String) {
        FirebaseMessaging.getInstance().subscribeToTopic(topic)
            .addOnCompleteListener { task ->
                if (task.isSuccessful) {
                    // 토픽 구독 성공
                    Log.d(TAG, "Subscribed to topic: $topic")
                } else {
                    // 토픽 구독 실패
                    Log.e(TAG, "Failed to subscribe to topic: $topic", task.exception)
                }
            }
    }

    private fun configureWebView() {
        myWebView.setInitialScale(200)
        with(myWebView.settings) {
            // 웹뷰 설정
            javaScriptEnabled = true
            domStorageEnabled = true
            allowFileAccess = true
            allowContentAccess = true
            setSupportMultipleWindows(true)
        }

        myWebView.webViewClient = WebViewClient()

        myWebView.webViewClient = object : WebViewClient() {
            override fun onReceivedSslError(
                view: WebView?,
                handler: SslErrorHandler?,
                error: SslError?
            ) {
                handler?.proceed() // 정상적이지 않은 SSL 인증서도 허용
            }

            override fun shouldOverrideUrlLoading(
                view: WebView,
                request: WebResourceRequest
            ): Boolean {
                Log.d(TAG, request.url.toString())

                if (request.url.scheme == "intent") {
                    try {
                        // Intent 생성
                        val intent =
                            Intent.parseUri(request.url.toString(), Intent.URI_INTENT_SCHEME)

                        // 실행 가능한 앱이 있으면 앱 실행
                        //if (intent.resolveActivity(packageManager) != null) {
                        startActivity(intent)
                        Log.d(TAG, "ACTIVITY: ${intent.`package`}")
                        Log.d(TAG, "카카오톡 실행")
                        return true
                        //}

                        Log.d(TAG, "카카오톡 공유하기 실행 못함")

                        // 실행 못하면 웹뷰는 카카오톡 공유하기 화면으로 이동
                        myWebView.loadUrl("https://www.hana1piece.store/")

                        /*
                        // 구글 플레이 카카오톡 마켓으로 이동
                        val intentStore = Intent(Intent.ACTION_VIEW)
                        intentStore.addCategory(Intent.CATEGORY_DEFAULT)
                        intentStore.data = Uri.parse("market://details?id=com.kakao.talk")
                        Log.d(TAG, "구글 플레이 카카오톡 마켓으로 이동")
                        startActivity(intentStore)
                         */

                    } catch (e: URISyntaxException) {
                        Log.e(TAG, "!!! 에러 Invalid intent request", e)
                    }
                }
                // 나머지 서비스 로직 구현
                return false
            }


        }

        myWebView.webChromeClient = object : WebChromeClient() {

            // 웹뷰에서 파일 선택을 요청할 때 호출되는 메서드
            override fun onShowFileChooser(
                webView: WebView?,
                filePathCallback: ValueCallback<Array<Uri>>?,
                fileChooserParams: FileChooserParams?
            ): Boolean {
                try {
                    mWebViewImageUpload = filePathCallback
                    var takePictureIntent: Intent? = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
                    if (takePictureIntent?.resolveActivity(packageManager) != null) {
                        var photoFile: File? = createImageFile()
                        takePictureIntent.putExtra("PhotoPath", cameraPath)

                        if (photoFile != null) {
                            cameraPath = "file:${photoFile.absolutePath}"
                            takePictureIntent.putExtra(
                                MediaStore.EXTRA_OUTPUT,
                                Uri.fromFile(photoFile)
                            )
                        } else {
                            takePictureIntent = null
                        }
                    }

                    // 이미지 선택을 위한 인텐트
                    val contentSelectionIntent =
                        Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI)
                    contentSelectionIntent.type = "image/*"

                    var intentArray: Array<Intent?>
                    if (takePictureIntent != null) {
                        intentArray = arrayOf(takePictureIntent)
                    } else {
                        intentArray = takePictureIntent?.get(0)!!
                    }

                    // 파일 선택을 위한 인텐트 실행
                    val chooserIntent = Intent(Intent.ACTION_CHOOSER)
                    chooserIntent.putExtra(Intent.EXTRA_INTENT, contentSelectionIntent)
                    chooserIntent.putExtra(Intent.EXTRA_TITLE, "사용할 앱을 선택해주세요.")
                    chooserIntent.putExtra(Intent.EXTRA_INITIAL_INTENTS, intentArray)
                    launcher.launch(chooserIntent)
                } catch (e: Exception) {
                }
                return true
            }
        }
    }

    // 이미지 파일 생성 함수
    fun createImageFile(): File? {
        @SuppressLint("SimpleDateFormat")
        val timeStamp = SimpleDateFormat("yyyyMMdd_HHmmss").format(Date())
        val imageFileName = "img_" + timeStamp + "_"
        val storageDir =
            Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES)
        return File.createTempFile(imageFileName, ".jpg", storageDir)
    }

    // Activity 결과를 처리하는 함수
    val launcher =
        registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
            if (result.resultCode == RESULT_OK) {
                val intent = result.data

                if (intent == null) {
                    // 바로 사진을 찍은 경우
                    val results = arrayOf(Uri.parse(cameraPath))
                    mWebViewImageUpload!!.onReceiveValue(results)
                } else {
                    // 이미지 앱을 통해 선택한 경우
                    val results = intent.data
                    mWebViewImageUpload!!.onReceiveValue(arrayOf(results!!))
                }
            } else {
                mWebViewImageUpload!!.onReceiveValue(null)
                mWebViewImageUpload = null
            }
        }

    // 뒤로 가기 버튼 이벤트
    override fun onBackPressed() {
        if (myWebView.canGoBack()) {
            myWebView.goBack()
        } else {
            if (System.currentTimeMillis() - backKeyPressedTime > 2000) {
                backKeyPressedTime = System.currentTimeMillis()
                Toast.makeText(this, "Press one more time to exit.", Toast.LENGTH_SHORT).show()
            } else {
                super.onBackPressed()
            }
        }
    }
}