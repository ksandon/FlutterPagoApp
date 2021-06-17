#Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Niubiz
-dontwarn lib.visanet.com.pe.visanetlib.**
-keep class lib.visanet.com.pe.visanetlib.** { *; }
-dontwarn com.cardinalcommerce.**
-keep class com.cardinalcommerce.** {*; }
-dontwarn com.threatmetrix.TrustDefender
-keep class com.threatmetrix.TrustDefender.** { *; }