require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Propro < AbstractPhp53Extension
  init
  desc "Reusable split-off of pecl_http's property proxy API."
  homepage "https://pecl.php.net/package/propro"
  url "https://github.com/m6w6/ext-propro/archive/release-1.0.2.tar.gz"
  sha256 "35b1d0881927049b3c7a14dc28306e2788f9b2bc937b1ef18e533a3bef8befce"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "facc3f7721f1b46d62a68224a850ecb5ca58521ec51a06244394a9137dfc0894" => :el_capitan
    sha256 "e51ef1ee8623931b579f6bdb3f035531ff08aab1a1c64cdebb73c02d5e245901" => :yosemite
    sha256 "d207bdcf28008ca400531b532c3a1387217baa0baf4c5abc58210eca99366811" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    include.install %w[php_propro.h]
    prefix.install "modules/propro.so"
    write_config_file if build.with? "config-file"
  end
end
