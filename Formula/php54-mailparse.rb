require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mailparse < AbstractPhp54Extension
  init
  desc "Mailparse is an extension for parsing and working with email messages."
  homepage "https://pecl.php.net/package/mailparse"
  url "https://pecl.php.net/get/mailparse-2.1.6.tgz"
  sha256 "73705197d2b2ee782efa5477eb2a21432f592c2cb05a72c3a037bbe39e02b5cc"
  head "https://svn.php.net/repository/pecl/mailparse/trunk"

  bottle do
    cellar :any_skip_relocation
    sha256 "e6ffe88378c06a2d0fcd57501854a0315957c11c27f47456d330ee22946cbd8f" => :el_capitan
    sha256 "71f15c961f5a404fccb1482fde917a17cd5584523d41b637c2f84ea53856a017" => :yosemite
    sha256 "269df3d88be56815a6d7e16eefc1a0b395005d2b9ff0da53c4cea6c1355fe63b" => :mavericks
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
