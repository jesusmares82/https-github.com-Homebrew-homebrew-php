require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Hprose < AbstractPhp55Extension
  init
  desc "Hprose for PHP."
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.5.4.tgz"
  sha256 "28733983073d5272b7096129dc23717c42485f905556082352bb0954b64bb996"
  head "https://github.com/hprose/hprose-pecl.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "eabe821027a52e91da7fd9d4c18c9c8f501756a0261f0b9c96e2f9dc99179048" => :el_capitan
    sha256 "4f228ce36aad4271f786ca9bf95dedca156a220fa81730d3e9563af46e678616" => :yosemite
    sha256 "1415554d74d4ebc58fc1386517187b61cc85909af045267510966640bff65e00" => :mavericks
  end

  def install
    Dir.chdir "hprose-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/hprose.so"
    write_config_file if build.with? "config-file"
  end
end
