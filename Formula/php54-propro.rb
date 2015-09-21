require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Propro < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/propro"
  url "https://pecl.php.net/get/propro-1.0.0.tgz"
  sha256 "9825d50ab4bb214428cd11c14c2f389c16aded09db16d266f27f147a7f2371f2"

  head "https://git.php.net/repository/pecl/php/propro.git"

  bottle do
    sha256 "52dc2a9795907ee71bffe972fa4a1a6638493bafd86b3ab8b213772126c52810" => :yosemite
    sha256 "3b3b4ab03a1b6436e363248d848b0ab7aa49846f808e4d56953e4b2846c9b617" => :mavericks
    sha256 "997f1379207b83994044a7d4c347a996e027c93c416d0aa43ec68de28ce038a5" => :mountain_lion
  end

  def install
    Dir.chdir "propro-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    include.install %w[php_propro.h]
    prefix.install "modules/propro.so"
    write_config_file if build.with? "config-file"
  end
end
