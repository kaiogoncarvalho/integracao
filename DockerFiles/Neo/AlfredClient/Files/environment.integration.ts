// The file contents for the current environment will overwrite these during build.
// The build system defaults to the dev environment which uses `environment.ts`, but if you do
// `ng build --env=prod` then `environment.prod.ts` will be used instead.
// The list of which env maps to which file can be found in `.angular-cli.json`.

export const environment = {
    production: false,
    endpoints: {
        "bpm"           :"http://st.bpm.idealinvest.com.br",
        "oauth"         :"http://st.oauth.idealinvest.srv.br",
        "alfredserver"  :"http://st.callcenter.idealinvest.srv.br"
    }
};