require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Oauth < AbstractPhp70Extension
  init
  desc "OAuth 1.0 consumer and provider"
  homepage "https://pecl.php.net/package/oauth"
  url "https://pecl.php.net/get/oauth-2.0.0.tgz"
  sha256 "f223a166e82ea51a241c229c5788e19dcafd8a1886ce2b7635cae29cb33c4f0e"
  head "https://svn.php.net/repository/pecl/oauth/trunk"

  bottle do
    sha256 "c31c53874c50603c4a6476961e04bc40c425968fd26e56a02e511bc77983b05a" => :yosemite
    sha256 "da5a3a51419d74ab4b4174eba540ff998e3c7836d2419cdfea06c003299d5978" => :mavericks
    sha256 "d0099c429a9c5246784e9ed11951850b26fce5e60e28caf24aeb8c48614eb2b9" => :mountain_lion
  end

  depends_on "pcre"

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
