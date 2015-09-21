require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55PdoDblib < AbstractPhp55Extension
  init
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 1
    sha256 "85a29880971033114990d3e7aebffd812a670e0d9a4987bc57465b54237f25c0" => :yosemite
    sha256 "df8997764a119d1024df19ef567bc9df48e9e64710669d0f1d09d92cec555d7f" => :mavericks
    sha256 "e7ed38aae9eaa612532dd8198498434e78c76497179f38bac90e1b8c4d84959b" => :mountain_lion
  end

  depends_on "freetds"

  def extension
    "pdo_dblib"
  end

  def install
    Dir.chdir "ext/pdo_dblib" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-dblib=#{Formula["freetds"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_dblib.so"
    write_config_file if build.with? "config-file"
  end
end
