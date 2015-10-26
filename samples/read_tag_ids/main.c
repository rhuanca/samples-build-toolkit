#include <stdio.h>
#include <string.h>
#include <curl/curl.h>

#include "parson.h"

char line[2048];
int line_index = 0;
char json_str[2048];

static void process_tag_read_data(JSON_Object *tag_read_data) {
    char tag_id[1024];
    strcpy(tag_id, json_object_get_string(tag_read_data, "data" ));
    printf("tag_id: %s\n", tag_id);
}

static void process_line(char *line) {
    int i;
    int j = 0;
    int len = strlen(line);
    char event_type[2048];
    JSON_Object *event;
    JSON_Value *json_value;

    if(strncmp(line, "data:", 5) == 0) {
        for( i = 6;i <len; i++ ) {
            json_str[j++] = line[i];
        }
        json_str[j] = '\0';
        json_value = json_parse_string(json_str);
        event = json_value_get_object(json_value);
        strcpy(event_type, json_object_get_string(event, "type"));
        if(strcmp(event_type, "TagReadData" ) == 0) {
            process_tag_read_data(event);
        }
    }
}

static size_t write_callback(void *contents, size_t size, size_t nmemb, void *userp)
{
    char *prt = contents;
    size_t real_size = size * nmemb;
    int i;

    for(i=0; i < real_size; i++ ) {
        if(prt[i] == '\n') {
            line[line_index] = '\0';
            line_index = 0;
            process_line(line);
        } else {
            line[line_index++] = prt[i];
        }
    }
    return real_size;
}

int main(int argc, char **argv)
{
    CURL *curl_handle;
    CURLcode res;

    curl_global_init(CURL_GLOBAL_ALL);

    printf(argv[1]);

    /* init the 64bits_curl session */
    curl_handle = curl_easy_init();

    /* specify URL to get */
    printf("Connecting to: http://localhost/rfid/events.\n");
    printf("\n");
    fflush(stdout);

    curl_easy_setopt(curl_handle, CURLOPT_URL, "http://localhost/rfid/events");

    /* send all data to this function  */
    curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, write_callback);

    /* get it! */
    res = curl_easy_perform(curl_handle);

    /* check for errors */
    if(res != CURLE_OK) {
        fprintf(stderr, "curl_easy_perform() failed: %s\n",
                curl_easy_strerror(res));
    }

    /* cleanup 64bits_curl stuff */
    curl_easy_cleanup(curl_handle);

    /* we're done with libcurl, so clean it up */
    curl_global_cleanup();
    return 0;
}
