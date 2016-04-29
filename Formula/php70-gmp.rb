require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    revision 13
    sha256 "9eea3296da300eaae81b28121271324674082b524098c9495df0a93693257f93" => :el_capitan
    sha256 "6eed2f3952033da80e7bdd43a2978b528e0f89eda238ceb323e9bcd2a0efbd40" => :yosemite
    sha256 "d23d0a1aba2d77323b423db083aa9257f0d9ea79bad6fd9072e632105cf42bca" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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






