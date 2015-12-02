require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Propro < AbstractPhp54Extension
  init
  desc "A reusable split-off of pecl_http's property proxy API."
  homepage "https://pecl.php.net/package/propro"
  url "https://pecl.php.net/get/propro-1.0.0.tgz"
  sha256 "9825d50ab4bb214428cd11c14c2f389c16aded09db16d266f27f147a7f2371f2"

  head "https://git.php.net/repository/pecl/php/propro.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "af0d0dc6e8ff501f8142d6bafbc5a02e7ac36965a1696a26f13fee293d7d4d2f" => :el_capitan
    sha256 "f1da11372ff3b11c04a5c2f0fb0435e4de037341c7e51a6bbebfb24c3a25098c" => :yosemite
    sha256 "41740ba11c9b4f2c63c5a79bb16c2515b5152d4839ae94b079a1a9b9df6021fe" => :mavericks
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
