require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mcrypt < AbstractPhp54Extension
  init
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "da4b4ef9dbc233dd74a8ad33ba6e88becbc33293a41205d1aeeef04aeb7aad16" => :yosemite
    sha256 "32c1bb241456ba87629c66cded09ef1eead94cc2e518faead6b8fa049bf44546" => :mavericks
    sha256 "ab373d3c4d7332b84a4bb14004a5b9321ced45c77d940106484e639c292d0528" => :mountain_lion
  end

  depends_on "mcrypt"

  def install
    Dir.chdir "ext/mcrypt"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-mcrypt=#{Formula['mcrypt'].opt_prefix}"
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file if build.with? "config-file"
  end
end
