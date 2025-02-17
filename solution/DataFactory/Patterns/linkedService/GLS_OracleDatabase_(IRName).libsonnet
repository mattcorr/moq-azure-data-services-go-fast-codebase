function(shortIRName = "", fullIRName = "")
{
    "name": "GLS_OracleDatabase_" + shortIRName,
    "properties": {
		"connectVia": {
			"referenceName": fullIRName,
			"type": "IntegrationRuntimeReference"
		},
		"description": "Generic Oracle DB",
        "parameters": {
            "Host": {
                "type": "string"
            },
            "Port": {
                "type": "string"
            },
            "SID": {
                "type": "string"
            },
            "UserName": {
                "type": "string"
            },
            "KeyVaultBaseUrl": {
                "type": "string"
            },
            "Secret": {
                "type": "string"
            }
        },
        "annotations": [],
        "type": "Oracle",
        "typeProperties": {
            "connectionString": "host=@{linkedService().Host};port=@{linkedService().Port};sid=@{linkedService().SID};user id=@{linkedService().UserName}",
            "password": {
                "type": "AzureKeyVaultSecret",
                "store": {
                    "referenceName": "GLS_AzureKeyVault_" + shortIRName,
                    "type": "LinkedServiceReference",
                    "parameters": {
                        "KeyVaultBaseUrl": {
                            "value": "@linkedService().KeyVaultBaseUrl",
                            "type": "Expression"
                        }
                    }
                },
                "secretName": {
                    "value": "@linkedService().Secret",
                    "type": "Expression"
                }
            }
        }
    }
}