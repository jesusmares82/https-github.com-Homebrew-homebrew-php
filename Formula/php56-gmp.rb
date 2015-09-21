require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 1
    sha256 "eca62299e84084307b6d569166637f34dfcdc12e3cdfc1e0debe62db8558fca8" => :yosemite
    sha256 "aecdf1c02db1cb8e5e13f6595502f17cd63242ce3e3b383af3b7d12d3a552acb" => :mavericks
    sha256 "f79a93165fdb8d23166c4ba822d8424919681afebbe1fb2300c864a6f1a10537" => :mountain_lion
  end

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
