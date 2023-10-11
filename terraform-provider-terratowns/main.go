//It specifies that it belongs to the main package. In Go, the main package is the entry point for the program.
package main
//It imports the fmt package, which provides functions for formatting and printing.
import (
    //"log"
    "fmt"
    "github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
    "github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"

)
//It defines the main function, which is the entry point for the program.

//Inside the main function, it uses the fmt.Println function to print "Hello, World!" to the console.
func main() {
    plugin.Serve(&plugin.ServeOpts{

        ProviderFunc: Provider,

    })
    fmt.Println("Hello, World!")
}

// In golang , a title case func will be exportdd
func Provider() *schema.Provider {
    var p *schema.Provider
    p = &schema.Provider{
        ResourcesMap: map[string] *schema.Resource{

        },
        DataSourcesMap: map[string] *schema.Resource{

        },
        Schema: map[string] *schema.Schema{
            "endpoint": {
                Type: schema.TypeString,
                Required:true,
                Description: "The endpoint for the external service",
            },
            "token": {
                Type: schema.TypeString,
                Sensitive: true, //Mark the token to sensitive to hide it in the log
                Required:true,
                Description: "Bearer token for the Authorisation",
            },
            "user_uuid":{
                Type: schema.TypeString,
                Required:true,
                Description: "The uuid for the configuration",
                // ValidateFunc: validateUUID,
            },
        },
    }
    // p.ConfigureContexFunc = providerconfigure(p)
     return p

}

// func validateUUID(v interface{}, k string) (ws []string, errors []error) {
//     log.print("validateUUID:Start")
//     value := v.(string)
//     if _, err := uuid.Parse(value); err != nil {
//         errors = append(errors, fmt.Errorf("%q must be a valid UUID, got: %s", k, value))
//     }
//     log.print("validateUUID:End")

//     return
// }

