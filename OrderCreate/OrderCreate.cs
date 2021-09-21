using System;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Extensions.Logging;

namespace OrderCreate
{
    public  class OrderCreate
    {
        [FunctionName("OrderCreate")]
        public  void Run([ServiceBusTrigger("ordercreatequeue", Connection = "ordercreatequeue")]string myQueueItem, ILogger log)
        {
            log.LogInformation($"C# ServiceBus queue trigger function processed message: {myQueueItem}");
        }
    }
}
