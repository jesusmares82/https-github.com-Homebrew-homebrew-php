require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mailparse < AbstractPhp71Extension
  init
  desc "Extension for parsing email messages."
  homepage "https://pecl.php.net/package/mailparse"
  url "https://pecl.php.net/get/mailparse-3.0.1.tgz"
  sha256 "42ee10de881a3739acf73ddef8800d80c3c57f70072f41bdb22e6e87ebc9cc62"
  head "https://github.com/php/pecl-mail-mailparse.git"

  bottle do
  end

  depends_on "pcre"

  def install
    Dir.chdir "mailparse-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/mailparse.so"
    write_config_file if build.with? "config-file"
  end
end
