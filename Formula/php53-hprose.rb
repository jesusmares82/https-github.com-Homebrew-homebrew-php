require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Hprose < AbstractPhp53Extension
  init
  desc "Hprose for PHP."
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.5.4.tgz"
  sha256 "28733983073d5272b7096129dc23717c42485f905556082352bb0954b64bb996"
  head "https://github.com/hprose/hprose-pecl.git"

  bottle do
    sha256 "47bce23398a026f30572af0e8ad5cf97c834c879fdbf193c3e23587712e71659" => :yosemite
    sha256 "0c515e5fcfd703c6b6a62d52ead1a176cbedcd0ffb2a3b6ce3b5546d36a1acb0" => :mavericks
    sha256 "f9c45f03a834fae4a564eb91baa4651601af03d20c61566d5e187e18fac8f797" => :mountain_lion
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
