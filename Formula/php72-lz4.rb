require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Lz4 < AbstractPhp72Extension
  init
  desc "Handles LZ4 de/compression"
  homepage "https://github.com/kjdev/php-ext-lz4"
  url "https://github.com/kjdev/php-ext-lz4/archive/0.2.3.tar.gz"
  sha256 "f484c8229b3c5af1385ce11e4b37999702757bad9bdb2eab8bfe48fa3f159904"
  head "https://github.com/kjdev/php-ext-lz4.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ca1ece747407e353e65e668d8ed1a426f5d6ed002232a522cb9a26bd3637d343" => :sierra
    sha256 "d245dad829a58e345c1cdd921a56206180ac3e370c945caf7464f5b8fb329d0e" => :el_capitan
    sha256 "3ce8074478b68e52ff7298eac05d6797db44d80f638d9e980fe024b70f14cd00" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/lz4.so"
    write_config_file if build.with? "config-file"
  end
end
