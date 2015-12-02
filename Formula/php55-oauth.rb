require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Oauth < AbstractPhp55Extension
  init
  desc "OAuth 1.0 consumer and provider"
  homepage "https://pecl.php.net/package/oauth"
  url "https://pecl.php.net/get/oauth-1.2.3.tgz"
  sha256 "86bb5ee37afe672d4532ad784c7f711855c79f0dabf0acacafd5344ab6cf0195"
  head "https://svn.php.net/repository/pecl/oauth/trunk"

  bottle do
    cellar :any_skip_relocation
    sha256 "bbfe73fe3e1f73b807b815b883ec56e3d9a87f879ada0e75b64194c525fbed24" => :el_capitan
    sha256 "d65d904cca8508e920e15e9055ebef81e263e5ec41cc27021321e795065052f8" => :yosemite
    sha256 "49d9a31b223eb27c6ee61c1f9bc70cc429b18339e30dc2e8b043448b4d9c7315" => :mavericks
  end

  def install
    Dir.chdir "oauth-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/oauth.so"
    write_config_file if build.with? "config-file"
  end
end
