/**
 * Created by geoffreynix on 6/19/25.
 */

trigger AccountTrigger on Account (before insert, before update, after insert, after update, before delete, after delete, after undelete) {
    switch on Trigger.operationType {
        when BEFORE_INSERT {
        }
        when BEFORE_UPDATE {

        }
        when BEFORE_DELETE {

        }
        when AFTER_INSERT {
            /*
  * When an account is inserted change the account
  * type to 'Prospect' if there is no value in the type field.
  * Trigger should only fire on insert.
  */
            for (Account acc: Trigger.new) {
                if (acc.Type == null) {
                    acc.Type = 'Prospect';
                }
                /*
 * When an account is inserted copy the shipping address to the billing address.
 * BONUS: Check if the shipping fields are empty before copying.
 * Trigger should only fire on insert.
 */
                if (acc.ShippingAddress != null) {
                    acc.BillingAddress = acc.ShippingAddress;
                }

                /*
* When an account is inserted set the rating to 'Hot' if the Phone, Website, and Fax ALL have a value.
* Trigger should only fire on insert.
*/          if (acc.Phone != null && acc.Website != null && acc.Fax != null) {
                    acc.Rating = 'Hot';
                }
                /*
* When an account is inserted create a contact related to the account with the following default values:
* LastName = 'DefaultContact'
* Email = 'default@email.com'
* Trigger should only fire on insert.
*/
            Contact con = new Contact();
                con.LastName = 'DefaultContact';
                con.Email = 'default@email.com';
                con.AccountId = acc.Id;
            }

        }
        when AFTER_UPDATE {

        }
        when AFTER_DELETE {

        }
        when AFTER_UNDELETE {

        }
    }

}