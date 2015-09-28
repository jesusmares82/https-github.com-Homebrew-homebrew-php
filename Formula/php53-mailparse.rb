require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Mailparse < AbstractPhp53Extension
  init
  homepage "https://pecl.php.net/package/mailparse"
  url "https://pecl.php.net/get/mailparse-2.1.6.tgz"
  sha256 "73705197d2b2ee782efa5477eb2a21432f592c2cb05a72c3a037bbe39e02b5cc"
  head "https://svn.php.net/repository/pecl/mailparse/trunk"

  bottle do
    cellar :any_skip_relocation
    sha256 "455516e206a7f8c02ee00a8e1dff6e8b4c5c5fca4b580776536a740d3aee668a" => :el_capitan
    sha256 "5457cf22695df5f4fd3dec5d955e91620c9f62ed7265d3fe75dd5fb17f61ed97" => :yosemite
    sha256 "6872e84faa6103f668b207e52fc7eb2528ff70e56431d90f029bc861a2fc92c3" => :mavericks
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
