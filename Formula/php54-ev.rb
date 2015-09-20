require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Ev < AbstractPhp54Extension
  init
  desc "interface to libev library"
  homepage "https://pecl.php.net/package/ev"
  url "https://pecl.php.net/get/ev-0.2.15.tgz"
  sha256 "801b2c39e081263f91d5a1d74e668e6c8ad199a34867c8e13e8fad3e83786fd5"
  head "https://bitbucket.org/osmanov/pecl-ev.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "0f75e6bf9da5e00066d2f952cf006e9dd7b8f9ffea450f4610ac6905e13237c5" => :el_capitan
    sha256 "473aaf403bd69ff85c9ff1ce4abc23af56bb4539252b6e247a90d76c4cd0fea6" => :yosemite
    sha256 "bff99dc7bf3cf9a6748b655f43f35e7a5039ca9cda9a24e89875c712880f765e" => :mavericks
  end

  depends_on "libev"

  # https://bitbucket.org/osmanov/pecl-ev/pull-requests/4
  patch :DATA

  def install
    Dir.chdir "ev-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    ENV["CFLAGS"] = "-Wno-return-type"
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-libev=#{Formula["libev"].opt_prefix}"
    system "make"
    prefix.install "modules/ev.so"
    write_config_file if build.with? "config-file"
  end
end

__END__
diff --git a/ev-0.2.15/libev/ev.c b/ev-0.2.15/libev/ev.c
index 03b697a..7a53901 100644
--- a/ev-0.2.15/libev/ev.c
+++ b/ev-0.2.15/libev/ev.c
@@ -1010,7 +1010,7 @@ ecb_inline uint64_t ecb_rotr64 (uint64_t x, unsigned int count) { return (x << (
   #define ecb_unreachable() __builtin_unreachable ()
 #else
   /* this seems to work fine, but gcc always emits a warning for it :/ */
-  ecb_inline void ecb_unreachable (void) ecb_noreturn;
+  ecb_noreturn ecb_inline void ecb_unreachable (void);
   ecb_inline void ecb_unreachable (void) { }
 #endif
 
