require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Intl < AbstractPhp55Extension
  init
  homepage "http://php.net/manual/en/book.intl.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "8095eb61ca94ca5707bbba51bb82a2e1e25a87cae4b0990564bf2a6fd41a26ec" => :yosemite
    sha256 "5c2548f6e3fd0069954da71f09ca407371dbdf3dda7c39321ac0af0d05cce6ac" => :mavericks
    sha256 "22d50807cd2f8fb491a5eda89468dd99c80e4ec6534704f7c9a91344b990aa74" => :mountain_lion
  end

  depends_on "icu4c"

  def install
    Dir.chdir "ext/intl"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--enable-intl",
                          "--with-icu-dir=#{Formula['icu4c'].prefix}"
    system "make"
    prefix.install "modules/intl.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<-EOS.undent

      ;intl.default_locale =
      ; This directive allows you to produce PHP errors when some error
      ; happens within intl functions. The value is the level of the error produced.
      ; Default is 0, which does not produce any errors.
      ;intl.error_level = E_WARNING
    EOS
  end

  test do
    shell_output("php -m").include?("intl")
  end
end
