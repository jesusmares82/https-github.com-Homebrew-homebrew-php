require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Uv < AbstractPhp72Extension
  init
  desc "interface to libuv library"
  homepage "https://github.com/bwoebi/php-uv"
  url "https://github.com/bwoebi/php-uv/archive/v0.1.1.tar.gz"
  sha256 "e576df44997a0b656deb4a1c2bfd1879fb3647419b0724bd6e87c7ddf997e2c1"
  head "https://github.com/bwoebi/php-uv.git"

  bottle do
    sha256 "0c0ed5f12874ffe089e7d1feaad070bb011fe584959ec599347824f7699ba837" => :sierra
    sha256 "71cf0d69386e6bd0eb203db38e5d4a2002cf2ae919ea89cd0f6f2f303fe3b663" => :el_capitan
    sha256 "c6b30bd22b009a150a481e0d224422151cf84c6de2b63bd701257988047db20f" => :yosemite
  end

  depends_on "libuv"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-uv=#{Formula["libuv"].opt_prefix}"
    system "make"
    prefix.install "modules/uv.so"
    write_config_file if build.with? "config-file"
  end
end
