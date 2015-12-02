require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Propro < AbstractPhp56Extension
  init
  desc "A reusable split-off of pecl_http's property proxy API."
  homepage "https://pecl.php.net/package/propro"
  url "https://pecl.php.net/get/propro-1.0.0.tgz"
  sha256 "9825d50ab4bb214428cd11c14c2f389c16aded09db16d266f27f147a7f2371f2"

  head "https://git.php.net/repository/pecl/php/propro.git"

  bottle do
    sha256 "3ee68c6accdae0cd0407e287ce997325a44d87f4635181c6166ca3df69c9a53a" => :yosemite
    sha256 "7eee6598c864ed7b7e0c0cd7f85290361f335e41ab367cf64bc367f7b64f2d99" => :mavericks
    sha256 "7297a92caa8c6b0b9395f9d253ac079df0c7049554e31d93ea3bbbf3425848d3" => :mountain_lion
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
