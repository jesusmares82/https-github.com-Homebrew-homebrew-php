require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Mailparse < AbstractPhp72Extension
  init
  desc "Extension for parsing email messages."
  homepage "https://pecl.php.net/package/mailparse"
  url "https://pecl.php.net/get/mailparse-3.0.1.tgz"
  sha256 "42ee10de881a3739acf73ddef8800d80c3c57f70072f41bdb22e6e87ebc9cc62"
  head "https://github.com/php/pecl-mail-mailparse.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ac32fa52ab657b1c9846b05c3c1530f440f2373bf63e66e95bde2a6fd8ff7c34" => :sierra
    sha256 "d2a97c5c73e8302a3bc3bd852a05a81b64b68967a855f14755c79f31b4735108" => :el_capitan
    sha256 "b7a983aea9c8e189b31316b31e18486135d712419a66bd28696a162ddc34c14f" => :yosemite
  end

  depends_on "pcre"

  def install
    Dir.chdir "mailparse-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/mailparse.so"
    write_config_file if build.with? "config-file"
  end
end
