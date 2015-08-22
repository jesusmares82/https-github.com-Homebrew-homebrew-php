require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Tidy < AbstractPhp70Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any
    sha256 "7f3f3fbdbefcb188ce764e0aef7ee945f26c91a8ab8b5eadf7b1d132b324d44b" => :yosemite
    sha256 "656879f9773d9ae80332a6d0dbb1014ed073751a9632e2cb103071954b0b3bd0" => :mavericks
    sha256 "9424fa5a374829541f431e078a98fa0981e5da4c3f81424bbb10586176e0ffb3" => :mountain_lion
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

  test do
    shell_output("php -m").include?("tidy")
  end
end


