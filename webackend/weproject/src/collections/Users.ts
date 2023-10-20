import { CollectionConfig } from 'payload/types';

const Users: CollectionConfig = {
  slug: 'users',
  auth: true,
  admin: {
    useAsTitle: 'email', // Assuming fullName is a suitable title
  },
  fields: [
    // Email added by default
    {
      name: 'fullName',
      type: 'text',
      label: 'Full Name',
    },
    {
      name: 'email',
      type: 'text',
      label: 'Username',
      unique: true, // Ensure usernames are unique
    },
    // Add more fields as needed
  ],
};

export default Users;
