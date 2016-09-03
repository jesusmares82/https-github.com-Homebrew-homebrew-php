require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Phalcon < AbstractPhp56Extension
  init
  desc "Full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.0.1.tar.gz"
  sha256 "18b24b99759523b8a6423dedb00fdbaad25fdd0fc3f76428987852afba081719"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9a91cc4c43042418a875e082606d9166bc6422547ad1e29873db7055af8248a4" => :el_capitan
    sha256 "b0f3db033e450b22f868f22a54cc07e2756f8e3646cb52c76333c9652b8c1e60" => :yosemite
    sha256 "5d54ed95efb46b9637274083332ce4957b9712c9b463f78745c881eae4c1405e" => :mavericks
  end

  depends_on "pcre"

  def install
    if MacOS.prefer_64_bit?
      Dir.chdir "build/php5/64bits"
    else
      Dir.chdir "build/php5/32bits"
    end

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end
