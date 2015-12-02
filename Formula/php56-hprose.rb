require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Hprose < AbstractPhp56Extension
  init
  desc "Hprose for PHP."
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.5.4.tgz"
  sha256 "28733983073d5272b7096129dc23717c42485f905556082352bb0954b64bb996"
  head "https://github.com/hprose/hprose-pecl.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "3a1ea6dc5ab3e19a17c784ff1159d1720429ea781f11d2fdd1f85596dd43cbe3" => :el_capitan
    sha256 "5d8504c7c0d038ed0b27cdec6ed1d969d6ad3dfad66a9193e270d46cc1f2c0db" => :yosemite
    sha256 "0d237e105f0a3407622b616a2171695077bb95e6713e3554e4c19f5538189dc5" => :mavericks
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
