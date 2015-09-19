require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Dbase < AbstractPhp56Extension
  init
  homepage 'https://pecl.php.net/package/dbase/5.1.0'
  url 'https://pecl.php.net/get/dbase-5.1.0.tgz'
  sha256 '20d6a40fb2efe4a06f503ec53512d02d71ceda87eac1f55208d7b5398f287a97'
  head 'https://svn.php.net/repository/pecl/dbase/trunk/'

  bottle do
    cellar :any_skip_relocation
    sha256 "a95c8f86d6af48b0c1d20dc2cc3d38b24a84c25c19796ceacdf6a291dfa8dfe6" => :el_capitan
    sha256 "bd92c41d07ff8947903c3e3b05a93fb50e31b75d5d01b574ad3171fab9078db4" => :yosemite
    sha256 "1c4fe8c4e373b2ca7114828831d31d953376ee8e6f0bf8eff53502e9fc373747" => :mavericks
  end

  def install
    Dir.chdir "dbase-5.1.0"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}"

    system "make"
    prefix.install "modules/dbase.so"
    write_config_file if build.with? "config-file"
  end
end
