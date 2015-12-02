require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mailparse < AbstractPhp55Extension
  init
  desc "Mailparse is an extension for parsing and working with email messages."
  homepage "https://pecl.php.net/package/mailparse"
  url "https://pecl.php.net/get/mailparse-2.1.6.tgz"
  sha256 "73705197d2b2ee782efa5477eb2a21432f592c2cb05a72c3a037bbe39e02b5cc"
  head "https://svn.php.net/repository/pecl/mailparse/trunk"

  bottle do
    cellar :any_skip_relocation
    sha256 "c7f316cc27a8fb01f86e393f8744a0006fd5ef11b9a880e0d00d9e226435d94f" => :el_capitan
    sha256 "80f6bd9add1b0c7c913edb4db7617ab8075e845b01f880bb942ecd6e9e781217" => :yosemite
    sha256 "36b3bdf9587dab23c030e06ba48519a0fc98d198aee8dd45721cbc1446468231" => :mavericks
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
