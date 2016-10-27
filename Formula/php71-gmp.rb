require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    sha256 "c8f856ecd4349b4e6cc456235a492fe9a4b5261175023890c294f4416ae822c3" => :sierra
    sha256 "d45b192f76ffcf25313f03d9bdb944389e13eb3ba0e5fe39e7b886d9ae16a476" => :el_capitan
    sha256 "b811db14fc64e2e1aee40f6c5cb06f4941c7f2c9299c22e256d9baa666191aa1" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                           "--with-gmp=#{Formula["gmp"].opt_prefix}"
    system "make"
    prefix.install "modules/gmp.so"
    write_config_file if build.with? "config-file"
  end
end
