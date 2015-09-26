require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Ssh2 < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/ssh2"
  url "https://pecl.php.net/get/ssh2-0.12.tgz"
  sha256 "600c82d2393acf3642f19914f06a7afea57ee05cb8c10e8a5510b32188b97f99"
  head "https://svn.php.net/repository/pecl/ssh2/trunk/"

  depends_on "libssh2"

  def install
    Dir.chdir "ssh2-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/ssh2.so"
    write_config_file if build.with? "config-file"
  end
end
