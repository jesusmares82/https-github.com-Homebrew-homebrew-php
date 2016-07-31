require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mailparse < AbstractPhp71Extension
  init
  desc "Extension for parsing email messages."
  homepage "https://pecl.php.net/package/mailparse"
  url "https://pecl.php.net/get/mailparse-3.0.1.tgz"
  sha256 "42ee10de881a3739acf73ddef8800d80c3c57f70072f41bdb22e6e87ebc9cc62"
  head "https://github.com/php/pecl-mail-mailparse.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "1a24edb8c93b8174c88a29fdce030df15b5a4305343b02dc458af98f5eae8402" => :el_capitan
    sha256 "e547f42061c43173ee7a9f4232a24a558a8e8f38dbe1a4a7fe4c244865c2914b" => :yosemite
    sha256 "dc3c7d29e32663e0b78c0c5e084cc562845d9d4b998520b09398e51fb45b49d7" => :mavericks
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
