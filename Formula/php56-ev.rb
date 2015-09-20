require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Ev < AbstractPhp56Extension
  init
  desc "interface to libev library"
  homepage "https://pecl.php.net/package/ev"
  url "https://pecl.php.net/get/ev-0.2.15.tgz"
  sha256 "801b2c39e081263f91d5a1d74e668e6c8ad199a34867c8e13e8fad3e83786fd5"
  head "https://bitbucket.org/osmanov/pecl-ev.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "7cb4b47ec84d42d2fff31711cd4811f0f757ac5fb60d449c30915981855399b1" => :el_capitan
    sha256 "3c3baf440535f5d510465aa44b38205103f3213a4e616db78f5f5c2a70b62d76" => :yosemite
    sha256 "05286cf12889c5320fc7ce4e25a257872079f89518a189951da0fcafb115a5c0" => :mavericks
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
 
