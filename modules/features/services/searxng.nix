{

  flake.nixosModules.searxng =
    { config, ... }:
    {
      systemd.services.searx = {
        wantedBy = [ "multi-user.target" ];
      };

      services.searx = {
        enable = true;
        environmentFile = config.sops.templates."searxng-env".path;
        settings = {
          general = {
            debug = false;
            instance_name = "Search";
            privacypolicy_url = false;
            donation_url = false;
            contact_url = false;
            enable_metrics = false;
            open_metrics = "";
          };

          search = {
            safe_search = 0;
            autocomplete = "duckduckgo";
            autocomplete_min = 4;
            default_lang = "auto";

            formats = [
              "html"
            ];
          };

          server = {
            port = 8888;
            bind_address = "127.0.0.1";
            limiter = false;
            public_instance = false;

            secret_key = "@SEARXNG_SECRET@";

            image_proxy = false;
            http_protocol_version = "1.0";
            method = "POST";

            default_http_headers = {
              X-Content-Type-Options = "nosniff";
              X-Download-Options = "noopen";
              X-Robots-Tag = "noindex, nofollow";
              Referrer-Policy = "no-referrer";
            };
          };

          ui = {
            default_theme = "simple";
            center_alignment = false;
            query_in_title = false;

            theme_args = {
              simple_style = "auto";
            };

            search_on_category_select = true;
            hotkeys = "default";
            url_formatting = "pretty";
          };

          outgoing = {
            request_timeout = 3.0;
            useragent_suffix = "";
            pool_connections = 100;
            pool_maxsize = 20;
            enable_http2 = true;
          };

          plugins = {
            "searx.plugins.calculator.SXNGPlugin".active = true;
            "searx.plugins.infinite_scroll.SXNGPlugin".active = false;
            "searx.plugins.hash_plugin.SXNGPlugin".active = true;
            "searx.plugins.self_info.SXNGPlugin".active = true;
            "searx.plugins.unit_converter.SXNGPlugin".active = true;
            "searx.plugins.ahmia_filter.SXNGPlugin".active = true;
            "searx.plugins.hostnames.SXNGPlugin".active = true;
            "searx.plugins.time_zone.SXNGPlugin".active = true;
            "searx.plugins.tracker_url_remover.SXNGPlugin".active = true;
          };

          categories_as_tabs = {
            general = { };
            images = { };
            it = { };
            science = { };
          };

          engines = [
            {
              name = "duckduckgo";
              engine = "duckduckgo";
              shortcut = "ddg";
              categories = [ "general" ];
            }
            {
              name = "brave";
              engine = "brave";
              shortcut = "br";
              categories = [
                "general"
                "web"
              ];
            }
            {
              name = "google";
              engine = "google";
              shortcut = "go";
              categories = [ "general" ];
            }
            {
              name = "mojeek";
              engine = "mojeek";
              shortcut = "mjk";
              categories = [
                "general"
                "web"
              ];
            }
            {
              name = "marginalia";
              engine = "marginalia";
              shortcut = "mar";
              categories = [ "general" ];
            }
            {
              name = "wikipedia";
              engine = "wikipedia";
              shortcut = "wp";
              categories = [ "general" ];
              display_type = [ "infobox" ];
            }
            {
              name = "wikidata";
              engine = "wikidata";
              shortcut = "wd";
              categories = [ "general" ];
              display_type = [ "infobox" ];
              weight = 2;
            }
            {
              name = "openlibrary";
              engine = "openlibrary";
              shortcut = "ol";
              categories = [ "general" ];
            }
            {
              name = "internet archive";
              engine = "internet_archive";
              shortcut = "ia";
              categories = [ "general" ];
            }
            {
              name = "arxiv";
              engine = "arxiv";
              shortcut = "arx";
              categories = [ "science" ];
            }
            {
              name = "astrophysics data system";
              engine = "astrophysics_data_system";
              shortcut = "ads";
              categories = [ "science" ];
            }
            {
              name = "pubmed";
              engine = "pubmed";
              shortcut = "pub";
              categories = [ "science" ];
            }
            {
              name = "europe pmc";
              engine = "europe_pmc";
              shortcut = "epmc";
              categories = [ "science" ];
            }
            {
              name = "semantic scholar";
              engine = "semantic_scholar";
              shortcut = "se";
              categories = [ "science" ];
            }
            {
              name = "openalex";
              engine = "openalex";
              shortcut = "oa";
              categories = [ "science" ];
            }
            {
              name = "crossref";
              engine = "crossref";
              shortcut = "cr";
              categories = [ "science" ];
            }
            {
              name = "inspirehep";
              engine = "inspire";
              shortcut = "insp";
              categories = [ "science" ];
            }
            {
              name = "math stackexchange";
              engine = "stackexchange";
              shortcut = "math";
              api_site = "math";
              categories = [
                "science"
                "q&a"
              ];
            }
            {
              name = "oeis";
              engine = "oeis";
              shortcut = "oeis";
              categories = [ "science" ];
            }
            {
              name = "github";
              engine = "github";
              shortcut = "gh";
              categories = [ "it" ];
            }
            {
              name = "github code";
              engine = "github_code";
              shortcut = "ghc";
              categories = [ "it" ];
            }
            {
              name = "stackoverflow";
              engine = "stackexchange";
              shortcut = "st";
              api_site = "stackoverflow";
              categories = [
                "it"
                "q&a"
              ];
            }
            {
              name = "mdn";
              engine = "json_engine";
              shortcut = "mdn";
              categories = [ "it" ];

              paging = true;
              search_url = "https://developer.mozilla.org/api/v1/search?q={query}&page={pageno}";
              results_query = "documents";
              url_query = "mdn_url";
              url_prefix = "https://developer.mozilla.org";
              title_query = "title";
              content_query = "summary";
            }
            {
              name = "nixos wiki";
              engine = "mediawiki";
              shortcut = "nixw";
              categories = [ "it" ];
              base_url = "https://wiki.nixos.org/";
              search_type = "text";
            }
            {
              name = "arch linux wiki";
              engine = "archlinux";
              shortcut = "al";
              categories = [ "it" ];
            }
            {
              name = "grep.app";
              engine = "grep_app";
              shortcut = "grep";
              categories = [ "it" ];
            }
            {
              name = "devdocs";
              engine = "devdocs";
              shortcut = "dev";
              categories = [ "it" ];
            }
            {
              name = "huggingface";
              engine = "huggingface";
              shortcut = "hf";
              categories = [
                "it"
                "science"
              ];
            }
            {
              name = "huggingface datasets";
              engine = "huggingface";
              shortcut = "hfd";
              huggingface_endpoint = "datasets";
              categories = [
                "it"
                "science"
              ];
            }
            {
              name = "huggingface spaces";
              engine = "huggingface";
              shortcut = "hfs";
              huggingface_endpoint = "spaces";
              categories = [ "it" ];
            }
            {
              name = "lobste.rs";
              engine = "lobsters";
              shortcut = "lo";
              categories = [ "it" ];
            }
            {
              name = "hackernews";
              engine = "hackernews";
              shortcut = "hn";
              categories = [ "it" ];
            }
            {
              name = "openstreetmap";
              engine = "openstreetmap";
              shortcut = "osm";
            }
            {
              name = "currency";
              engine = "currency_convert";
              shortcut = "cc";
            }
            {
              name = "wttr.in";
              engine = "wttr";
              shortcut = "wttr";
            }
          ];
        };
      };
    };
}
