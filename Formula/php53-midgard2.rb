require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Midgard2 < AbstractPhp53Extension
  init
  desc "PHP5 API for Midgard persistent storage framework"
  homepage "http://www.midgard-project.org"
  url "https://github.com/midgardproject/midgard-php5/archive/12.09.1.tar.gz"
  sha256 "633ed2dce0c43222c13b2be1d2d044343f37e69cbdf727abc78ac53b6d871fe3"
  head "https://github.com/midgardproject/midgard-php5.git", :branch => "ratatoskr"

  bottle do
    sha256 "779b73f738a031a458610d3c3f464c246ece09acd6975875e2eed52ac058ecef" => :el_capitan
    sha256 "11703baa83b9c6c7bbdfc56b9902f4a6a05ba657fb78c950a3e7b4487aee6d77" => :yosemite
    sha256 "5b79a63a35c8e895789fc0c50867ff87da636b242a1d50972c560849c3b57d3b" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "midgard2"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/midgard2.so"
    write_config_file if build.with? "config-file"
  end
end
