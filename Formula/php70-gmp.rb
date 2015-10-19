require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    revision 4
    sha256 "35143558163a60f51baac15ab81c78305d5a191f574c1afe5fac17a91c76a2f1" => :el_capitan
    sha256 "559a54a13d0c4903f1f46606763b155efa09d9771b368f261bde86a55c0f31d3" => :yosemite
    sha256 "af863f6356af9a117f52674b527b7b9b3ac3ece0d9271d1fab429788e4b67182" => :mavericks
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
