require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Yaml < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/yaml"
  desc "YAML-1.1 parser and emitter"
  url "https://pecl.php.net/get/yaml-1.3.0.tgz"
  sha256 "bf4696386fbd4e8435628d84ccb8c261c9e481888c7e1ce537cccceadcb57500"
  head "https://github.com/php/pecl-file_formats-yaml.git"

  bottle do
    sha256 "234af5422372265f23ce5ce82c568dd098a42e9b03e8f29de9167ebb3f4b540e" => :yosemite
    sha256 "a92d92e620c77335f9bd3741561ea9b2d92363d6daadd08f850297b0367fe2c3" => :mavericks
    sha256 "63d2ed5e4d77d17862db3acde5054964ffe5fbe4edc70ed00d139cabe47d6c37" => :mountain_lion
  end

  depends_on "libyaml"

  def install
    Dir.chdir "yaml-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-yaml=#{Formula["libyaml"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaml.so"
    write_config_file if build.with? "config-file"
  end
end
