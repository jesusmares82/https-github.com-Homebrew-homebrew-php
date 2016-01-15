require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mailparse < AbstractPhp70Extension
  init
  desc "Extension for parsing email messages."
  homepage "https://pecl.php.net/package/mailparse"
  url "https://pecl.php.net/get/mailparse-3.0.0.tgz"
  sha256 "92a80f7d2cda597ca75186531006b802fa278f33d1b3b854420f48832e5bc7da"
  head "https://github.com/php/pecl-mail-mailparse.git"

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
