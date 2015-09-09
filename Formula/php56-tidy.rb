require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Tidy < AbstractPhp56Extension
  init
  homepage "http://php.net/manual/en/book.tidy.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    cellar :any
    revision 1
    sha256 "29e3e8b1649f78c2ca26dad5d9b3a649d6eba2f84ba5dd1e1696a184fd967872" => :yosemite
    sha256 "fc59ad45faa65ef4186b6ca0e83ff69b67ea99b1a1d618e5608d25d963230f31" => :mavericks
    sha256 "dcce1bc99316e6237ee4519def4cc2244500f25875572506a0104c773169478e" => :mountain_lion
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


