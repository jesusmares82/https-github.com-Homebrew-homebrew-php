require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mailparse < AbstractPhp70Extension
  init
  desc "Extension for parsing email messages."
  homepage "https://pecl.php.net/package/mailparse"
  url "https://pecl.php.net/get/mailparse-3.0.0.tgz"
  sha256 "92a80f7d2cda597ca75186531006b802fa278f33d1b3b854420f48832e5bc7da"
  head "https://github.com/php/pecl-mail-mailparse.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "b2cc166d2c82924f872893bd0aae63ee2263f07eb19fee42c0167f4b176050e6" => :el_capitan
    sha256 "e32ced209150a87d1454c36def685ee6315545bbdd4aa9357138b62ec3bac65d" => :yosemite
    sha256 "b0612a357ed0d526f242d9bf851d987199409eb2225157ec8c1be0c92a2bcacc" => :mavericks
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
