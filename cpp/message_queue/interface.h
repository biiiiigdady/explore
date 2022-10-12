#ifndef MESSAGE_QUEUE_INTERFACE_H_
#define MESSAGE_QUEUE_INTERFACE_H_
#include <memory>

namespace mq {

class MessageQueue;
struct message_queue_config_t;
struct message_t;

std::unique_ptr<MessageQueue> CreateMessageQueue(
    const message_queue_config_t& cfg);
std::unique_ptr<message_t> GetMessage();
void PutMessage(const message_t& msg);
}  // namespace mq

#endif  // MESSAGE_QUEUE_INTERFACE_H_