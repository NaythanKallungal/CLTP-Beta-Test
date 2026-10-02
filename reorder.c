#include "reorder.h"

static struct listnode* find_news(struct listnode** );
static struct listnode* reverse(struct listnode* );
static struct listnode* merge(struct listnode* , struct listnode* );

struct listnode* reorder_list(struct listnode* node) {
    struct listnode* news_head = find_news(&node);
    news_head = reverse(news_head);
    node = merge(node, news_head);
    return node;
}

static struct listnode* find_news(struct listnode** node) {
    struct listnode* follow = NULL;
    struct listnode* itr = *node;
    while (itr && itr->age == OLD) {
        follow = itr;
        itr = itr->next;
    }
    follow->next = NULL;
    if (itr == *node) {
        *node = NULL;
    }
    return itr;
}

static struct listnode* reverse(struct listnode* node) {
    struct listnode* prev = NULL;
    while (node) {
        struct listnode* next = node->next;
        node->next = prev;
        prev = node;
        node = next;
    }
    return prev;
}

static struct listnode* merge(struct listnode* node1, struct listnode* node2) {
    struct listnode head = {0};
    struct listnode* itr = &head;
    while (node1 && node2) {
        itr->next = node1;
        node1 = node1->next;
        itr = itr->next;
        itr->next = node2;
        itr = itr->next;
        node2 = node2->next;
    }
    if (node1) {
        itr->next = node1;
    } else {
        itr->next = node2;
    }
    return head.next;
}

void print_list(struct listnode* node) {
    struct listnode* itr = node;
    while (node) {
        print_age(itr->age);
        printf(" [%d]\n", itr->value);
        itr = itr->next;
    }
}

void free_list(struct listnode* node) {
    while (node) {
        struct listnode* next = node->next;
        free(node);
        node = next;
    }
}
