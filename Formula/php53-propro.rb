require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Propro < AbstractPhp53Extension
  init
  desc "A reusable split-off of pecl_http's property proxy API."
  homepage "https://pecl.php.net/package/propro"
  url "https://pecl.php.net/get/propro-1.0.0.tgz"
  sha256 "9825d50ab4bb214428cd11c14c2f389c16aded09db16d266f27f147a7f2371f2"

  head "https://git.php.net/repository/pecl/php/propro.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "facc3f7721f1b46d62a68224a850ecb5ca58521ec51a06244394a9137dfc0894" => :el_capitan
    sha256 "e51ef1ee8623931b579f6bdb3f035531ff08aab1a1c64cdebb73c02d5e245901" => :yosemite
    sha256 "d207bdcf28008ca400531b532c3a1387217baa0baf4c5abc58210eca99366811" => :mavericks
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
