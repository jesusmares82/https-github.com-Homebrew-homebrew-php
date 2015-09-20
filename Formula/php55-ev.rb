require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Ev < AbstractPhp55Extension
  init
  desc "interface to libev library"
  homepage "https://pecl.php.net/package/ev"
  url "https://pecl.php.net/get/ev-0.2.15.tgz"
  sha256 "801b2c39e081263f91d5a1d74e668e6c8ad199a34867c8e13e8fad3e83786fd5"
  head "https://bitbucket.org/osmanov/pecl-ev.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "3ca928c2fb301466a8d556883b0d3e7b180a437cd4da83263bc175514ea93c2e" => :el_capitan
    sha256 "ca94e65f28b7aeb4778226ec6873b5566fe95784611c744b71d6e7352ac92fdb" => :yosemite
    sha256 "7ff0b1e3e649e16173f25770bc77e31873261339a0043037b9f4efc545e8c41a" => :mavericks
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
 
