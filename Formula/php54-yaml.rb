require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Yaml < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/yaml"
  desc "YAML-1.1 parser and emitter"
  url "https://pecl.php.net/get/yaml-1.2.0.tgz"
  sha256 "fdf0eec6bf16b0c45e58076a2048f96140a778463724fb82ab49ab5fb4c7e19a"
  head "https://github.com/php/pecl-file_formats-yaml.git"

  bottle do
    sha256 "65af5592ca00ecf843a8852f244a21a40ba6491dd42a6f1a660a251d5187eb81" => :yosemite
    sha256 "89116612d39540d4d750c214155e287b14e45dae386d5f840df1f4bba0e9bc74" => :mavericks
    sha256 "cb5f43d4c12d80ffdb663b7af36324a5bdb4840ed263b36052c93b2bae6b24dd" => :mountain_lion
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
