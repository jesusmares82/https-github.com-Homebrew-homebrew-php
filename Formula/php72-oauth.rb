require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Oauth < AbstractPhp72Extension
  init
  desc "OAuth 1.0 consumer and provider"
  homepage "https://pecl.php.net/package/oauth"
  url "https://pecl.php.net/get/oauth-2.0.2.tgz"
  sha256 "87ce1a5d585f439f0ead2683f2f7dca76d538df9143da681978356b5e1c6e8e8"
  head "https://github.com/php/pecl-web_services-oauth.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "8e800a206c530343f1a380d241e01c4270c6909c8d2be79561ae6ba89e03a626" => :sierra
    sha256 "550a7f3cc2145782d95a3404d6784bfb8d0cd724316ad0458886aff7b59849b2" => :el_capitan
    sha256 "5acc56f5b50e75e1d497c19481f836c1994790c62bb2fdb057472272ecffb618" => :yosemite
  end

  depends_on "pcre"

  def install
    Dir.chdir "oauth-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/oauth.so"
    write_config_file if build.with? "config-file"
  end
end
