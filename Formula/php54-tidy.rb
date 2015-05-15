require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Tidy < AbstractPhp54Extension
  init
  homepage "http://php.net/manual/en/book.tidy.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "eda94ad4c3e4f76f2b10f0580e719d4fd3d09e8ef9987605facf74f5307811e4" => :yosemite
    sha256 "12e4e78034ab22b892121f97159de48d902337416dccdf09c9d1adfd21cb26dd" => :mavericks
    sha256 "d18c817e0a02013f7739b0c0fac00207b8a0581bad45705b401107f68ef21beb" => :mountain_lion
  end

  def install
    Dir.chdir "ext/tidy"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
