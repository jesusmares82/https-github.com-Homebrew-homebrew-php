require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Stats < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/stats"
  url "https://pecl.php.net/get/stats-1.0.3.tgz"
  sha256 "e032e02052acf2013f0578da823d60b0b2a89eb5e1dd1379cf0a65c090dffdfc"
  head "https://svn.php.net/repository/pecl/stats/trunk/"

  def install
    Dir.chdir "stats-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/stats.so"
    write_config_file if build.with? "config-file"
  end
end
