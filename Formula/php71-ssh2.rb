require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ssh2 < AbstractPhp71Extension
  init
  desc "Provides bindings to the functions of libssh2"
  homepage "https://pecl.php.net/package/ssh2"
  url "https://pecl.php.net/get/ssh2-1.0.tgz"
  sha256 "6a93891878b23904a773eb814fec7aea4ea00b4a412ee779c8535ed9c5e46ced"
  head "https://github.com/php/pecl-networking-ssh2.git"

  depends_on "libssh2"

  def install
    Dir.chdir "ssh2-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-ssh2=#{Formula["libssh2"].opt_prefix}"
    system "make"
    prefix.install "modules/ssh2.so"
    write_config_file if build.with? "config-file"
  end
end
