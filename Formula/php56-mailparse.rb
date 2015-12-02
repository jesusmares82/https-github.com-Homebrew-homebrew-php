require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mailparse < AbstractPhp56Extension
  init
  desc "Mailparse is an extension for parsing and working with email messages."
  homepage "https://pecl.php.net/package/mailparse"
  url "https://pecl.php.net/get/mailparse-2.1.6.tgz"
  sha256 "73705197d2b2ee782efa5477eb2a21432f592c2cb05a72c3a037bbe39e02b5cc"
  head "https://svn.php.net/repository/pecl/mailparse/trunk"

  bottle do
    cellar :any_skip_relocation
    sha256 "ae073139dd740e4b20fdfe3c556b853d9a98ce93b1a8378c5318a512fa836e63" => :el_capitan
    sha256 "4480020ab19b1ebcad9a10faf6eeccdaeb66aac29a6944236bce37db138c0625" => :yosemite
    sha256 "a61e38f88ec77f048259f1b642a67cc519366e79043c1eecb24df316f94b1e1d" => :mavericks
  end

  depends_on "pcre"

  def install
    Dir.chdir "mailparse-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/mailparse.so"
    write_config_file if build.with? "config-file"
  end
end
